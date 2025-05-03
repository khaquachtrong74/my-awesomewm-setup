#!/usr/bin/env python3
import sys, time, itertools

frames = [
r"""
      ／￣￣￣￣￣＼
     /   FastFetch!   \
    |    Stay speedy!  |
     \   ╰(•̀ ³ •́ )━☆ /
      ＼＿＿＿＿＿／

         (\_/)
         (•ㅅ•)
        /   づ
""",
r"""
      ／￣￣￣￣￣＼
     /   FastFetch!   \
    |    Stay speedy!  |
     \   ╰(•̀ ³ •́ )━☆ /
      ＼＿＿＿＿＿／

         (\_/)
         (•ㅅ•)
        づ   \
""",
r"""
      ／￣￣￣￣￣＼
     /   FastFetch!   \
    |    Stay speedy!  |
     \   ╰(•̀ ³ •́ )━☆ /
      ＼＿＿＿＿＿／

        (\_/)
        (•ㅅ•)
       /   づ
""",
r"""
      ／￣￣￣￣￣＼
     /   FastFetch!   \
    |    Stay speedy!  |
     \   ╰(•̀ ³ •́ )━☆ /
      ＼＿＿＿＿＿／

        (\_/)
        (•ㅅ•)
        づ   \
"""
]

for frame in itertools.cycle(frames):
    # clear screen
    sys.stdout.write("\033[2J\033[H")
    sys.stdout.write(frame)
    sys.stdout.flush()
    time.sleep(0.4)
