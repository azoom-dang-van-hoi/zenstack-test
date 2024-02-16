import { DMMF } from '@prisma/generator-helper';
import { PluginOptions } from '@zenstackhq/sdk';
import { Model } from '@zenstackhq/sdk/ast';
export declare function generate(model: Model, options: PluginOptions, dmmf: DMMF.Document): Promise<string>;
