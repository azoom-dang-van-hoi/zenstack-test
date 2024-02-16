import type { DMMF } from '@prisma/generator-helper';
import { PluginOptions } from '@zenstackhq/sdk';
import { Model } from '@zenstackhq/sdk/ast';
export declare const name = "ZenStack MarkDown";
export default function run(model: Model, options: PluginOptions, dmmf: DMMF.Document): Promise<void>;
