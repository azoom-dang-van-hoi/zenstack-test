import { enhance } from "@zenstackhq/runtime"
import { prisma } from "./db.js"

import express from "express"
import cors from "cors"

const app = express()
const PORT = process.env.PORT || 5005

app.use(cors())
app.use(express.json())

// Middleware to fake user context to request
app.use((req, res, next) => {
  if (
    !+req.query.id ||
    (!+req.query.organizationId && req.query.role !== "admin")
  ) {
    return res.sendStatus(403)
  }
  const user = {
    id: +req.query.id,
    email: req.query.email,
    role: req.query.role,
    organizationId:
      req.query.role === "admin" ? undefined : +req.query.organizationId,
  }
  req.user = user
  next()
})

// Query parkings normaly using Prisma
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

// Query parkings using Zenstack enhanced Prisma Client
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

app.listen(PORT, () => console.log(`Server is running on port ${PORT}`))
