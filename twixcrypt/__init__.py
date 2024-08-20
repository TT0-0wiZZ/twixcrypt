"""
    MIT License

    Copyright (c) 2024 ttwiz_z

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
"""


from pathlib import Path
from subprocess import check_output, CalledProcessError
from platform import system


path = Path(__file__).parent.resolve()


class Cryptography:
    def __init__(self, key: str):
        assert len(key.encode()) == 16 or len(key.encode()) == 24 or len(key.encode()) == 32, "Key must be either 16, 24 or 32 bytes long"

        self.key = key

    def encrypt(self, message: str) -> str:
        while len(message.encode()) % 16 != 0:
            message += " "

        try:
            output = check_output([f"{path}\\runtime\\lune-{system().lower()}", "run", f"{path}\\cryptography", "encrypt", self.key, message], shell=True).strip().decode()
        except CalledProcessError:
            raise OSError("OS is not supported")

        if "[WARN]" in output:
            raise ValueError(output[7:])
        else:
            return output

    def decrypt(self, message: str) -> str:
        try:
            output = check_output([f"{path}\\runtime\\lune-{system().lower()}", "run", f"{path}\\cryptography", "decrypt", self.key, message], shell=True).strip().decode()
        except CalledProcessError:
            raise OSError("OS is not supported")

        if "[WARN]" in output:
            raise ValueError(output[7:])
        else:
            return output
