import { User } from "@prisma/client";

/**
 * UpdateUser type. Object type
 * which is used to update a user with 
 * prisma ORM. 
 */
export type UpdateUser = {
    where: { uuid: string},
    data: {
        idToken: string | undefined,
        authenticationUser: string | undefined,
        modifiedAt: undefined,
        changeTag: { increment: 1},
        employee_uuid: undefined,
    }
}; 


/** Create User Type */
export type CreateUser = {
    data: User
};

