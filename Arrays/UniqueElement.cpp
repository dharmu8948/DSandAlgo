// WAP to find the unique element from array
#include <bits/stdc++.h>
using namespace std;
int findUnique(vector<int> arr) {
    int ans = 0;
    for(int i=0;i<arr.size();i++) {
        ans = ans^arr[i];
    }
    return ans;
}
int main() {
    int n;
    cin>>n;
    vector<int> arr(n);
    for(int i=0;i<n;i++) {
      cin>>arr[i];  
    }
    int ans = findUnique(arr);
    cout<<"Unique element is : "<<ans<<endl;

    return 0;
}