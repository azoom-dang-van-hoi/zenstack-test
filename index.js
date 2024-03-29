import { enhance } from "@zenstackhq/runtime"
import { prisma } from "./db.js"
import { getHistories, getHistoryById } from './services/azoom-notif.js'

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
app.get("/v1/procedures", async (req, res) => {
  const user = req.user
  const where =
    user.role === "admin"
      ? {}
      : {
          OR: [
            {
              organizationId: null,
              parkingContract: {
                parking: {
                  organizationId: user.organizationId,
                  OR: [
                    {
                      regionId: null,
                    },
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
              },
            },
            {
              parkingContractId: null,
              organizationId: user.organizationId,
              contractorId: {
                not: null,
              },
              contractor: {
                parkingContracts: {
                  some: {
                    parking: {
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
                  },
                },
              },
            },
          ],
        }
  const userProcedures = await prisma.userProcedure.findMany({
    where,
  })
  res.send(userProcedures)
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

app.get("/v2/procedures", async (req, res) => {
  const user = req.user
  const enhancedClient = enhance(prisma, {
    user,
  })
  const userProcedures = await enhancedClient.userProcedure.findMany()
  res.send(userProcedures)
})

app.get("/v2/custom-notifications/:id", async (req, res) => {
  const user = req.user
  const notificationId = req.params.id

  const enhancedClient = enhance(prisma, {
    user,
  })

  const notification = await enhancedClient.notification.findUnique({
    where: {
      id: +notificationId
    }
  })

  if (!notification) return res.sendStatus(404)

  const history = getHistoryById(notification.historyId)

  const staffNameExcute = await enhancedClient.organizationStaff.findFirst({
    where: {
      email: history.executedStaff
    }
  })

  const notificationHistory = {
    ...history,
    executedStaff: staffNameExcute?.name,
    executedStaffEmail: staffNameExcute?.email
  }

  res.send(notificationHistory)
})

app.listen(PORT, () => console.log(`Server is running on port ${PORT}`))
