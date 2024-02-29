import { enhance } from "@zenstackhq/runtime"
import { prisma } from "./db.js"

// Get user context from request
const user = {
  id: 1,
  email: "org-1@gmail.com",
  role: "owner",
  name: "ORG-1",
  organizationId: 1,
}

// Create Proxy Prisma Client to check policies
const enhancedClient = enhance(prisma, {
  user,
})

async function bootstrap() {
  // Query parkings normaly using Prisma 
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
  
  // Query parkings using Zenstack enhanced Prisma Client
  const parkingsEnhanced = await enhancedClient.parking.findMany({
    include: {
      region: true,
      organization: true,
    },
  })
}

bootstrap()
