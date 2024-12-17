import { NextFunction, Request, Response } from "express";
import { PrismaClient, User } from "@prisma/client";
import { thisUser } from "../utils/userUtils";
import NotFoundError from "../errors/NotFoundError";
import { CreateUser, UpdateUser } from "../models/user/types";
import { ServiceManagementDeleteQuery } from "../models/queries/delete";

/** Prisma Client */
const prisma = new PrismaClient();


/**
 * Module function which creates the user update 
 * object to be passed in the prisma update function.
 * @param reqBody User object passed within the request body
 * @param user Existing user object acquire from DB. 
 * @returns UpdateUser type for prisma update.
 * @author jcameron
 */
export const _userUpdateData = (reqBody: User, user: User): UpdateUser => {
    return {
        where: {uuid: user.uuid},
        data: {
            // properties labeled with undefined are updated by backend or other requests.
            idToken: reqBody.idToken || undefined,
            authenticationUser: reqBody.authenticationUser || undefined,
            modifiedAt: undefined, 
            changeTag: { increment: 1},
            employee_uuid: undefined,
        },
    }
};



/**
 * Function used to create a new user.
 * @param req Request express object
 * @param res Response express object
 * @param next Next Middleware function
 * @author jcameron
 */
export const create = async (req: Request, res: Response, next: NextFunction) => {
    try {
        console.log(`Creating User From ==> ${JSON.stringify(req.body, null, '\t')}`);
        const userData: CreateUser = {data: req.body}
        const user = await prisma.user.create(userData);
        res.status(201).send(user);
    } catch(err) {
        next(err);
    }
}

/**
 * Function used to update an existing user.
 * @param req Request express object
 * @param res Response express object
 * @param next Next Middleware function
 * @author jcameron
 */
export const update = async (req: Request, res: Response, next: NextFunction) => {
    try {
        // Get User
        const user = await thisUser(req);

        // Does user exist? 
        if(user){
            console.log(`Updating User ==> ${JSON.stringify(req.body, null, 2)}`);
            const reqBody: User = req.body as User; 
            res.status(201).send(await prisma.user.update(_userUpdateData(reqBody, user)));
            // Error user doesn't exist.
        } else next(new NotFoundError({code: 404, message: "Not Found", context:{ message: "User doesn't exist"}}));
    } catch(err){
        // Handle unforeseen errors in middleware.
        next(err);
    }
}; 

/**
 * Function used to remove this user.
 * @param req Request express object
 * @param res Response express object
 * @param next Next Middleware function
 * @author jcameron
 */
export const remove = async (req: Request, res: Response, next: NextFunction) => {
    try {
        // Get existing user.
        const user = await thisUser(req);
        if(user){
            // Send back removed user to client.
            const query: ServiceManagementDeleteQuery = { where: {uuid: user.uuid}}
            const removedUser = await prisma.user.delete(query);
            res.status(200).send(removedUser);
          // Call Error middleware  
        } else next(new NotFoundError({code: 404, message: "Not Found", logging: true}));
    } catch (error) {
        next(error)
    }
}


/**
 * Function used to get this user.
 * @param req Request express object
 * @param res Response express object
 * @param next Next Middleware function
 * @author jcameron
 */
export const get = async (req: Request, res: Response, next: NextFunction) => {
    try {
        // Get the user
        const user = await thisUser(req); 
        if(user){
            // Send back user to client.
            res.status(200).send(user);
          // Call Error middleware  
        } else next(new NotFoundError({code: 404, message: "Not Found", logging: true}));
    } catch (error) {
        // Pass Server error to middleware.
        next(error);
    }
}


/**
 * Function used to getAll users from the system.
 * @param req Request express object
 * @param res Response express object
 * @param next Next Middleware function
 * @author jcameron
 */
export const getAll = async (req: Request, res: Response, next: NextFunction) => {
        try {
            // Get ALL, empty array if none.
            res.status(200).send(await prisma.user.findMany()) 
        } catch (error) {
            next(error)
        }
    
}
