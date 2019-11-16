import { exec } from '@actions/exec'
import { which } from '@actions/io'
import { setFailed } from '@actions/core'
import { resolve } from 'path'

async function run() {
  try {
    await exec(await which('bash', true), ['src/updater.sh'], { cwd: resolve(__dirname, '..') })
  } catch (error) {
    setFailed(error.message)
  }
}

run().catch((error) => setFailed(error.message))
