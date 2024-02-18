import { enhance } from "@zenstackhq/runtime"
import { prisma } from "./db.js"
import { ParkingSchema } from "./node_modules/.zenstack/zod/models/Parking.schema.js"

const user = {
  id: 1,
  email: "org-1@gmail.com",
  role: "owner",
  name: "ORG-1",
  organizationId: 1,
}

const parkingData = {
  name: "Parking 1",
  organizationId: user.organizationId,
  regionId: null,
  id: 3,
  zip: "123456",
}

const enhancedClient = enhance(prisma, {
  user,
})

async function bootstrap() {
  console.time("Prisma query")
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
  console.log("Prisma query: ", parkings)
  console.timeEnd("Prisma query")
  console.time("Enhanced query")
  const parkingsEnhanced = await enhancedClient.parking.findMany({
    include: {
      region: true,
      organization: true,
    },
  })
  console.log("Enhanced query: ", parkingsEnhanced)
  console.timeEnd("Enhanced query")

  

  console.log(ParkingSchema.safeParse(parkingData)?.error)

  // Create parking
  await enhancedClient.parking.create({
    data: {
      name: "Parking 1",
      organizationId: user.organizationId,
      regionId: 2,
      address: "123456",
    },
  })
}

bootstrap()
