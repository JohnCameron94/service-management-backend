import  { Router } from "express";
import { create, update, remove, get, getAll } from "../controllers/user.controller";
import { validCreateUser } from "../middlewares/validation";

// Instantiate Express Router
const router = Router(); 
router.post("/user", validCreateUser, create); // Create new User
router.patch("/user", update); // Update Existing User
router.delete("/user", remove); // Delete existing user
router.get("/user", get); // Get current user
router.get("/users", getAll); // All Users


export default router;