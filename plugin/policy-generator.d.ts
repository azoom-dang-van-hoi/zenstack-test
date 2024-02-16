import { DataModel } from '@zenstackhq/sdk/ast';
export default class PolicyGenerator {
    readonly CRUD: string[];
    private zModelGenerator;
    generate(dataModel: DataModel): string;
}
