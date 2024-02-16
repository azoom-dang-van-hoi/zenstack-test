import { readFile, writeFile } from "fs/promises"
async function bootstrap() {
  const schemaContent = await readFile("prisma/schema.prisma", "utf-8")
  const newSchemaContent = schemaContent.replace(
    /model\s+User\s+\{[\s\S]*?\}/gm,
    ""
  )
  await writeFile("prisma/schema.prisma", newSchemaContent, "utf-8")
}

bootstrap()
