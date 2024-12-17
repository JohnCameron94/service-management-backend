// src/index.ts
import express, { Express, Request, Response } from "express";
import userRouter from "./routes/user.routes";
import loggerMiddleware from "./middlewares/logger";
import dotenv from "dotenv";
import { errorHandler } from "./middlewares/errorHandler";
import "./pollyfill";

dotenv.config();

const app: Express = express();
const port = process.env.PORT || 3000;

// Parser and Logger
app.use(express.json());
app.use(loggerMiddleware);

// // Enable Cors
// app.use((req, res, next) => {
//   res.header("Access-Control-Allow-Origin", "*")
//   res.header("Access-Control-Allow-Headers", "*")
//   next()
// });


// User router 
app.use("/", userRouter);

// Error Handler
app.use(errorHandler);


app.listen(port, () => {
  console.log(`[server]: Server is running at http://localhost:${port}`);
});