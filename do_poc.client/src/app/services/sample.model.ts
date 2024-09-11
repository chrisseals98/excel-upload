import { Result } from "./result.model"

export type Sample = {
    sampleNumber: string,
    locId: string,
    datetime: Date,
    depth: number,
    results: Result[]
}