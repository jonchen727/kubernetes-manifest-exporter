# kubernetes-manifest-exporter
Scripts to export all kubernetes manifests from your cluster.

This comes in handy when you want to migrate a cluster, or use a gitbased config management tool such as [kpt-config-sync](https://github.com/GoogleContainerTools/kpt-config-sync) or [Anthos Config Management](https://cloud.google.com/anthos-config-management/docs/how-to/install-anthos-config-management) 


## Reqirements

Ensure that you have kubectl and are on the correct context for the cluster you want to export

You will need `kubectl neat`, this cleans the manifest files from excess metadata.
```bash
kubectl krew install neat
```

Visit the [kubectl-neat](https://github.com/itaysk/kubectl-neat) repo page for more information on kubectl-neat.

## Usage

### Non-namespaced Resources
```bash
./nonnamespacebackup.sh
```
#### What it does 
1. Creates a folder named cluster
2. Grabs all non-namespaced api resources 
3. Iterates through the resources to get names per resource 
4. Iterates through named resources and grabs the yaml output piping through `kubectl neat`
5. Saves the yaml file to `cluster/[resource]/[resource name].yaml`

### Name-spaced Resources
```bash
./namespacebackup.sh
``` 

#### What it does
1. Creates a folder named namespaces
2. Grabs all namespaced api resources 
3. Grabs all namespaces 
4. Iterates through each namespace
5. Iterates through the resources to get names per resource 
6. Iterates through named resources and grabs the yaml output piping through `kubectl neat`
7. Saves the yaml file to `namespaces/[namespace name]/[resource]/[resource name].yaml` 

Note some kube api resources are deprecated/cannot be gotten with the kubectl get command. 
