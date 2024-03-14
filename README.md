# Overview

Project này cung cấp use case thực tế khi apply logic phân quyền sử dụng Zenstack cho dự án CPO: Phân quyền truy cập parking resource theo region.

- Phân quyền đối với các resource có mối quan hệ trực tiếp theo region:
  - Quản lý parking
  - Quản lý contract
- Phân quyền đối với các resource có mối quan hệ gián tiếp theo region:
  - Quản lý procedure (đơn xin thay đổi thông tin)

# [Zenstack](https://zenstack.dev/)

#### Introduce:

ZenStack is an open-source toolkit built above Prisma - the most popular ORM for Node.js. ZenStack pushes Prisma's power to a new level and boosts the development efficiency of every layer of your stack - from access control, to API development, and all the way up to the frontend

- ORM with built-in access control and data validation
- A plugin system for great extensibility
- Auto-generated API document, CRUD API - RESTful & tRPC and frontend data query hooks

#### Core concept

- ZenStack được xây dựng trên Prisma, nó bao gồm 2 phần để thực hiện tính năng ủy quyền:
  - Zmodel language: được mở rộng từ Prisma Model Language, kế thừa tất cả cú pháp của Prisma và thêm các thuộc tính mở rộng để thực hiện chức năng phân quyền, validation data

```ts
// base.zmodel
abstract model Base {
    id String @id
    author User @relation(fields: [authorId], references: [id])
    authorId String

    // 🔐 allow full CRUD by author
    @@allow('all', author == auth())
}
```

```ts
// schema.zmodel
import "base"
model Post extends Base {
    title String
    published Boolean @default(false)

    // 🔐 allow logged-in users to read published posts
    @@allow('read', auth() != null && published)
}
```

- Runtime API: Zenstack cung cấp công cụ tạo Proxy PrismaClient dùng để phân quyền người dùng truy cập DB dựa vào Zenstack Policies (Được generate ra dựa vào Zmodel language).

```ts
import { enhance } from "@zenstackhq/runtime"

// a regular Prisma client
const prisma = new PrismaClient()

async function getPosts(userId: string) {
  // create an enhanced Prisma client that has access control enabled
  const enhanced = enhance(prisma, { user: userId })

  // only posts that're visible to the user will be returned
  return enhanced.post.findMany()
}
```

- 2 thành phần trên hoàn toàn tách biệt, không bị phụ thuộc lẫn nhau. Vì vậy khi sử dụng có thể custom sâu Zenstack Policies mà không bị giới hạn bởi cú pháp hiện tại của Zenstack Model

```ts
// Custom policy
// policy.ts
function Post_read(context, db) {
  const user = context.user
  if (!user || !user.id) return { OR: [] }
  return {
    AND: [{ published: true }],
  }
}

export default {
  guard: {
    post: {
      create: true,
      update: true,
      postUpdate: true,
      read: Post_read,
      delete: true,
    },
  },
}
```

# Demo phân quyền quản lý resource theo khu vực:

## Define model

- Để thực hiện check current user đang truy cập vào DB, cần thêm model `User` để cung cấp auth context cho Zenstack Language.

```ts
// zmodel/user.zmodel
model User {
  id Int @id @default(autoincrement())
  // If user is owner, organizationId is required
  organizationId Int?
  email String @unique
  name String?
  role String // admin, owner
  @@map("user")
  @@ignore // Remove this model from the prisma schema because it's not a real table.
}
```

- Xây dựng Model theo đối tượng tham gia CPO:
  - Admin: Admin azoom, không được lưu thông tin trong CPO
  - Owner: Chủ bãi đỗ xe. Mỗi owner sẽ quản lý staff của họ, mỗi 1 staff quản lý bãi đỗ xe, contract theo khu vực.

```ts
// zmodel/organization.zmodel
model Organization extends BaseModal {
    email String? @map("email") @db.VarChar(255)
    parkings Parking[]
    organizationStaffs OrganizationStaff[]
    regions Region[]

    @@map("organization")
}

model OrganizationStaff extends BaseModal {
    organization Organization @relation(fields: [organizationId], references: [id])
    organizationId Int @map("organization_id")
    email String @map("email") @db.VarChar(255)

    organizationStaffRegions OrganizationStaffRegion[]

    @@map("organization_staff")
}

model OrganizationStaffRegion extends BaseModal {
    organizationStaffId Int @map("organization_staff_id")
    regionId Int @map("region_id")
    organizationStaff OrganizationStaff @relation(fields: [organizationStaffId], references: [id])
    region Region @relation(fields: [regionId], references: [id])

    @@map("organization_staff_region")
}
```

```ts
// zmodel/parking.zmodel
model Parking extends BaseModal {
    regionId Int? @map("region_id")
    region Region? @relation(fields: [regionId], references: [id])
    organizationId Int @map("organization_id")
    organization Organization @relation(fields: [organizationId], references: [id])


    parkingContracts ParkingContract[]

    @@map("parking")
}
```

```ts
// zmodel/region.zmodel
model Region extends BaseModal {
    organizationId Int @map("organization_id")
    organization Organization @relation(fields: [organizationId], references: [id])

    parkings Parking[]
    organizationStaffRegions OrganizationStaffRegion[]

    @@map("region")
}
```

- Contractor: End user thuê bãi đỗ xe, 1 contractor có thể thuê nhiều bãi đỗ xe, mỗi bãi đỗ xe cần có hợp đồng riêng. Sau khi có contract, contractor có thể update lại thông tin contract, hoặc thông tin contractor, khi đó họ cần tạo đơn yêu cầu thay đổi thông tin (procedure) cho owner / admin approve.

```ts
// zmodel/contract.zmodel
model Contractor extends BaseModal {
  name String
  email String @unique

  parkingContracts ParkingContract[]
  userProcedures UserProcedure[]
  notifications Notification[]

  @@map("contractor")
}

model ParkingContract extends BaseModal {
  parkingId Int @map("parking_id")
  parking Parking @relation(fields: [parkingId], references: [id])
  contractorId Int? @map("contractor_id")
  contractor Contractor? @relation(fields: [contractorId], references: [id])

  userProcedures UserProcedure[]

  @@map("parking_contract")
}

model UserProcedure extends BaseModal {
  parkingContractId Int? @map("parking_contract_id")
  parkingContract ParkingContract? @relation(fields: [parkingContractId], references: [id])
  organizationId Int? @map("organization_id")
  organization Organization? @relation(fields: [organizationId], references: [id])
  type Int @map("type")
  contractorId Int? @map("contractor_id")
  contractor Contractor? @relation(fields: [contractorId], references: [id])

  @@map("user_procedure")
}
```

- Ở mỗi một step đăng ký contract, sẽ có thông báo hoàn thành gửi cho contractor / owner:

```ts
// zmodel/contract.zmodel

model Notification extends BaseModal {
  createdOrganizationId Int? @map("created_organization_id")
  contentType Int @map("content_type")
  historyId String? @map("history_id")
  email String @map("email") @db.VarChar(255)
  contractorId Int? @map("contractor_id")
  contractor Contractor? @relation(fields: [contractorId], references: [id])
  content String @map("content") @db.VarChar(255)

  @@map("notification")
}

```

## Phân quyền đối với các resource có mối quan hệ trực tiếp theo region:

### Admin có full quyền truy cập tất cả resource:

- Tất cả model thêm policy check current user có phải là admin hay không, nếu là current user là admin thì cho phép full quyền resource.

```ts
model Parking {
    @@allow('all', auth().role === 'admin')
}
```

### Thêm policy quản lý parking theo khu vực

- Điều kiện:
  - Parking và owner staff thuộc cùng 1 owner: `auth().organizationId == organizationId`
  - Parking không quản lý theo khu vực (regionId == null) hoặc nếu parking thuộc khu vực `X` thì owner staff phải quản lý khu vực đó (`region.organizationStaffRegions?[organizationStaffId == auth().id`). + Note: expressions <collection>?[condition] => có ít nhất 1 item thỏa mãn condition

```ts
model Parking {
    ...
    @@allow('all',
        (auth().role == 'owner' &&
            auth().organizationId == organizationId &&
            (
                regionId == null ||
                region.organizationStaffRegions?[organizationStaffId == auth().id]
            )
        )
    )
}
```

### Thêm policy quản lý contract theo khu vực

- Bảng contract không có quan hệ trực tiếp tới khu vực, cần phải thông qua relation đến bảng parking sau đó thực hiện phânn quyền theo parking tươngg tự như trên.trên

```ts
model Contract {
    ...
    @@allow('all',
        (auth().role == 'owner' &&
            auth().organizationId == parking.organizationId &&
            (
                parking.regionId == null ||
                parking.region.organizationStaffRegions?[organizationStaffId == auth().id]
            )
        )
    )
}
```

## Phân quyền đối với các resource có mối quan hệ gián tiếp theo region:

### Thêm policy quản lý procedure theo khu vực

- Procedure lưu thông tin contractor muốn thay đổi, có thể là thông tin contract, thông tin contractor.
- Trong trường hợp contractor thay đổi thông tin contract, field parking_contract_id not null, có thể dựa vào field này để phân quyền khu vực tương tự phần trên.
- Trường hợp thay đổi thông tin của contractor, sẽ ảnh hưởng tới nhiều contract thuộc nhiều owner khác nhau. Trong trường hợp này field parking_contract_id = null, organization_id khác null

=> Cần dựa vào field contractor: contractor có đăng ký ít nhất 1 contract được quản lý theo khu vực của owner staff đang login.

```ts
model UserProcedure {
    ...
    @@allow('all',
    auth().role == 'owner' &&
      // Update contractor information affects multiple contracts of various owners.
      (
          parkingContractId == null &&
          auth().organizationId == organizationId &&
          contractorId != null &&
          contractor.parkingContracts?[
            parking.regionId == null ||
            parking.region.organizationStaffRegions?[organizationStaffId == auth().id]
          ]
      ) ||
      // Upate contract information
      (
          organizationId == null &&
          parkingContract.parking.organizationId == auth().organizationId &&
          // Loic check region
          (
              parkingContract.parking.regionId == null ||
              parkingContract.parking.region.organizationStaffRegions?[organizationStaffId == auth().id]
          )
      )
    )
}
```

## Generate Prisma model

- Sau khi define policy trong Zmodel, cần generate ra Prisma model và file Policy để sử dụng cho API: 
```bash
# Generate Prisma file + Policy from Zenstack Model
# The Prisma model file is created and stored in the prisma/schema.prisma file.
# The default policy file is stored in the /node_modules/.zenstack/policy.js file.

$ zenstack generate
```

## Sử dụng Zenstack Runtime API để thực hiện phân quyền.

- Zenstack cung cấp hàm `enhance` để tạo Access Prisma Proxy. Khi sử dụng Access Prisma Proxy, Zenstack mặc định thêm Policy vào trong context `where` khi query. 
- Khi sử dụng hàm `enhance` cần cung cấp Prisma Client và context user:
```ts
import { enhance } from "@zenstackhq/runtime"
const enhancedClient = enhance(prisma, {
    user,
})
/// Use enhancedClient to query to DB.
```

```ts
// index.js
// API get parkings
app.get("/v2/parkings", async (req, res) => {
  const user = req.user
  const enhancedClient = enhance(prisma, {
    user,
  })
  const parkingsEnhanced = await enhancedClient.parking.findMany({
    include: {
      region: true,
      organization: true,
    },
  })
  res.send(parkingsEnhanced)
})
```

- Khi không sử dụng Zenstack, API sẽ cần thêm câu điều kiện `where` khi query (API `/v1/*`):

```ts
app.get("/v1/parkings", async (req, res) => {
  const user = req.user
  const parkings = await prisma.parking.findMany({
    where: {
      organizationId: user.organizationId,
      OR: [
        { regionId: null },
        {
          region: {
            organizationStaffRegions: {
              some: {
                organizationStaffId: user.id,
              },
            },
          },
        },
      ],
    },
    include: {
      organization: true,
      region: true,
    },
  })
  res.send(parkings)
})
```

# Kết luận

Trong quá trình apply Zenstack cho CPO tôi thấy Zenstack có một số ưu điểm và hạn chế sau:

## Ưu điểm:

- Quy tắc truy cập DB được tập trung, giúp dễ dàng thêm quy tắc phân quyền mà không cần quan tâm đến logic ở API đang kiểm tra.
- Bảo mật ứng dụng được cải thiện: Zenstack runtime API sẽ tự động check quyền read,update,create,delete của user đang login mà API không không thêm điều kiện where => Giảm thiểu được tình trạng khi dev miss quyền truy cập.
- Trải nghiệm phát triển (DX) tốt hơn: Zenstack hỗ trợ chia nhiều file (điều mà Prisma chưa hỗ trợ), giúp giảm thiểu việc fix conflict liên quan đến format file Prisma schema trong quá trình phát triển.
- Cú pháp của Zenstack cũng giống với Prisma, nên những người đã quen với Prisma có thể dễ dàng tiếp cận Zenstack.
- Ngoài ra khi apply vào CPO, tôi thấy còn 1 số ưu điểm sau: 
    +  Zenstack hỗ trợ tạo schema Zod mặc định, thuận lợi cho việc áp dụng Zod vào CPO sau này.
    +  Zenstack hỗ trợ plugin một cách đơn, cho phép mở rộng cú pháp của nó và tận dụng hệ sinh thái của Prisma.

## Hạn chế:

- Zenstack chỉ support cho Prisma query dạng Object Model, nếu thực tế 1 bảng không thực hiện query được bằng Object Model thì sẽ không thể sử dụng Zenstack.
- Không sử dụng được transaction Sequential operations transaction: Hiện tại CPO đang không sử dụng dạng này nên không bị ảnh hưởng.
- Zenstack tập trung logic phân quyền nên nếu không có rule viết phân quyền sau này sẽ rất dài và khó đọc.
- Mặc dù Zenstack cung cấp cú pháp kế thừa, tuy nhiên chưa có cú pháp kế thừa quyền theo model, nên đôi khi viết logic quyền đang bị dupplicate => Cần thêm cú pháp extends phần quyền.
