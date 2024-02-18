import type { DMMF } from "@prisma/generator-helper"
import { PluginOptions } from "@zenstackhq/sdk"
import { Model } from "@zenstackhq/sdk/ast"
import { removeIgnoreModel } from "./remove-ignore-model"
export const name = "ZenStack Plugin"

export default async function run(
  model: Model,
  options: PluginOptions,
  dmmf: DMMF.Document
) {
  if (process.env.DISABLE_ZENSTACK_MD === "true" || options.disable) {
    return
  }

  await removeIgnoreModel(model, options, dmmf)
}
