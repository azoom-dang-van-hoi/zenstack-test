import { Argument, ArrayExpr, AttributeArg, BinaryExpr, DataModelAttribute, DataModelFieldAttribute, Expression, FieldInitializer, InvocationExpr, LiteralExpr, MemberAccessExpr, ObjectExpr, ReferenceArg, ReferenceExpr, UnaryExpr } from "@zenstackhq/sdk/ast";
/**
 * Options for the generator.
 */
export interface ZModelCodeOptions {
    binaryExprNumberOfSpaces: number;
    unaryExprNumberOfSpaces: number;
}
export default class ZModelCodeGenerator {
    private readonly options;
    constructor(options?: Partial<ZModelCodeOptions>);
    generateAttribute(ast: DataModelAttribute | DataModelFieldAttribute): string;
    generateAttributeArg(ast: AttributeArg): string;
    generateExpression(ast: Expression): string;
    generateObjectExpr(ast: ObjectExpr): string;
    generateObjectField(field: FieldInitializer): string;
    generateArrayExpr(ast: ArrayExpr): string;
    generateLiteralExpr(ast: LiteralExpr): string;
    generateUnaryExpr(ast: UnaryExpr): string;
    generateBinaryExpr(ast: BinaryExpr): string;
    generateReferenceExpr(ast: ReferenceExpr): string;
    generateReferenceArg(ast: ReferenceArg): string;
    generateMemberExpr(ast: MemberAccessExpr): string;
    generateInvocationExpr(ast: InvocationExpr): string;
    generateArgument(ast: Argument): string;
    private get binaryExprSpace();
    private get unaryExprSpace();
    private isParenthesesNeededForBinaryExpr;
    private isCollectionPredicateOperator;
}
