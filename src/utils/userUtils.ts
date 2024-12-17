import { PrismaClient } from "@prisma/client";
import { Request } from "express";
import NotAuthorizedError from "../errors/NotAuthorizedError";
import NotFoundError from "../errors/NotFoundError";

const prisma = new PrismaClient(); 

export const thisUser = async (req: Request) => {
    return await getThisUser (req);
}

const getThisUser = async (req: Request) => {
    try {
        return await prisma.user.findFirst({ where:{idToken: "1234"}});
    } catch (error) {
        throw new NotFoundError({code: 404, message: "Not Found", logging:true, context:{message:"User doesn't exist."}});
    }
}

const thisUserAuth = (req: Request) => {
    /** Todo figure out how to do user auth */
    return null;
}

