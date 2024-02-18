import { DMMF } from "@prisma/generator-helper"
import { PluginOptions } from "@zenstackhq/sdk"
import { DataModel, Model, isDataModel } from "@zenstackhq/sdk/ast"
import { readFile, writeFile } from "fs/promises"

export async function removeIgnoreModel(
  model: Model,
  options: PluginOptions,
  dmmf: DMMF.Document
) {
  const prismaSchemaFile =
    options.schemaPath.split("/").slice(0, -1).join("/") +
    "/prisma/schema.prisma"
  const schemaContent = await readFile(prismaSchemaFile, "utf-8")
  let newSchemaContent = schemaContent
  
  const dataModels = model.declarations.filter((x) =>
    isDataModel(x)
  ) as DataModel[]
  dataModels.forEach((model) => {
    model.attributes.forEach((at) => {
      if (at.decl.$refText === "@@ignore") {
        const regex = new RegExp(`model\\s+${model.name}\\s+\\{[\\s\\S]*?\\}`, "gm")
        newSchemaContent = newSchemaContent.replace(regex, "")
      }
    })
  })
  await writeFile("prisma/schema.prisma", newSchemaContent, "utf-8")
}
