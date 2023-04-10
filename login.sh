#!/bin/bash
#/etc/profile.d に配置することで、ログイン時にLINEに通知が飛ぶようになる。

ip=`echo ${SSH_CLIENT} | cut -d " " -f 1`           #ログインしたクライアントIPアドレスを取得
user=`whoami`                                        #ログインユーザーを取得
token="####################" #notifyのトークン
url="https://notify-api.line.me/api/notify"         #notifyのURL

# ローカルログインかリモートログインか判定
if [ -z "$ip" ]; then
    type="local_login"
else
    type="remote_login
ip:$ip"
fi

#メッセージを作成  "message=" は必須
message=".
user : $user
type : $type
"

#curlで送信
#-o /dev/null はログイン時に出力されるメッセージを消す
curl -s -o /dev/null -X POST -H "Authorization: Bearer $token" -F "message=$message" $url