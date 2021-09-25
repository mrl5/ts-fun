import dotenv from 'dotenv';
import express from 'express';

dotenv.config();
const app = express();
const nodeEnv = process.env.NODE_ENV;
const port = process.env.SERVER_PORT || 3000;

app.get('/', (req, res) => {
    const msg = getMsg();
    res.json(getJson(msg));
});

app.listen(port, () => {
    console.log('env:', nodeEnv);
    console.log('port:', port);
});

function getMsg(): string {
    return 'Hello World!';
}

function getJson(msg: string): Body {
    return { msg };
}

interface Body {
    msg: string;
}
