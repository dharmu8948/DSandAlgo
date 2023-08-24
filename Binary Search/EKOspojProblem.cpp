// EKO SPOJ problem using Binary Search
#include <bits/stdc++.h>
using namespace std;
bool isPossibleSolution(vector<long long int> trees, long long int m, long long int mid) {
    long long int woodCullected = 0;
    for(long long int i=0;i<trees.size();i++) {
        if(trees[i] > mid) {
            woodCullected += trees[i] - mid;
        }
    }
    return woodCullected>=m;
}
int maxSawBladeHeight(vector<long long int> trees, long long int m){
    long long int start = 0, ans = -1;
    long long int end = *max_element(trees.begin(), trees.end());
    while(start<=end) {
        long long int mid = start + (end - start)/2;
        if(isPossibleSolution(trees,m,mid)) {
            ans = mid;
            start = mid + 1;
        }else {
            end = mid - 1;
        }
    }
    return ans;
}
int main() {
    // Write C++ code here
    long long int n,m;
    cin>>n>>m;
    vector<long long int> trees;
    for(long long int i=0;i<n;i++) {
        long long int height;
        cin>>height;
        trees.push_back(height);
    }
    cout<<"MaxSawHeightBlade is : "<<maxSawBladeHeight(trees,m)<<endl;
    return 0;
}