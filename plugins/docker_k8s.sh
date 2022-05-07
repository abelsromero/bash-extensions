#!/bin/sh

alias k="kubectl"
alias kctx="kubectx"
alias kns="kubens"
source <(kubectl completion zsh)

docker_clean_all() {
	docker rmi -f $(docker images -a -q)
	docker system prune -f
  docker volume prune -f
}

k_port_forward() {
  local pod_name=$(kubectl get pods --no-headers | grep $1 | awk '{print $1}')
  local pods_count=$(echo $pod_name | wc -l)
  local port=8080
  if [ "$#" -eq 2 ]; then
    port="$2"
  fi

  if [ "$pods_count" -gt "1" ]; then
    echo "[WARNING] Found multiple candidates:"
    i=1
    echo "$pod_name" | while IFS= read -r line
    do
      echo "  $i) $line"
      i=$((i+1))
    done
    echo "[INFO] Select one (type number and ENTER):"
    selected_index=1
    read selected_index
    i=1
    echo "$pod_name" | while IFS= read -r line
    do
      if [ "$selected_index" -eq "$i" ]; then
        echo "[INFO] Forwarding...$line"
        kubectl port-forward $line $port:8080
        return
      else
        i=$((i+1))
      fi
    done
  else
    echo "[INFO] Forwarding...$pod_name"
    kubectl port-forward $pod_name $port:8080
    return
  fi
}
