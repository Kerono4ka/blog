#!/bin/bash
kill -9 $(lsof -i :3000 -t)
