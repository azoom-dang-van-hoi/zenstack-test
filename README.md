# Zenstack demo

## Requirements

* yarn
* node version 18

## Initial Setup
1. Install package: `yarn`
2. Copy file `template.env` to `.env`
3. Build plugin: `yarn build:plugin`
4. Generate Prisma schema: `yarn generate`
5. Migrate schema: `yarn prisma migrate dev`
6. Add data example to database
7. Run server: `yarn dev`
