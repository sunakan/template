#!/usr/bin/env bash
set -Eeuo pipefail
#set -x
# -E: 関数やサブシェルでエラーが起きた時トラップ発動
# -e: エラーが発生した時点でスクリプトを終了
# -u: 未定義の変数を使用した場合にエラーを発生
# -x: スクリプトの実行内容を表示(debugで利用)
# -o pipefail: パイプライン内のエラーを検出

usage() {
  echo "$0" >&2
  echo '概要:' >&2
  echo '  - 引数(target)に対して挨拶をする' >&2
  echo '実行方法:' >&2
  echo "  - $0 <target>" >&2
  echo '実行例:' >&2
  echo "  - $0 Taro" >&2
  exit 2
}

err() {
  echo "error: ${BASH_SOURCE[1]}:${BASH_LINENO[0]}: $BASH_COMMAND" >&2
  exit 1
}
trap err ERR

hello() {
  local target
  readonly target="$1"
  echo "Hello $target"
}

START_TIME=$(docker run --rm -it ghcr.io/sunakan/ztime:v0.0.1 --tokyo)
echo "🚀START:    $0 $* ${START_TIME}"
(($# == 1)) || (echo '引数は1つだけ必要です' >&2 && usage)

hello "$1"

FINISHED_TIME=$(docker run --rm -it ghcr.io/sunakan/ztime:v0.0.1 --tokyo)
echo "✅FINISHED: $0 $* ${FINISHED_TIME}"
