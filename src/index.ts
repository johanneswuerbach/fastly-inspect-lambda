import { Handler } from 'aws-lambda'
import { promisify, inspect } from 'util'
import { exec } from 'child_process';

const execP = promisify(exec)

export const handler: Handler<void, string> = async (event, context) => {
  const { stdout } = await execP('./fastly-inspect')
  return JSON.parse(stdout)
}
