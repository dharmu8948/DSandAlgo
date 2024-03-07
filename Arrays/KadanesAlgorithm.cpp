// Online C++ compiler to run C++ program online
#include <bits/stdc++.h>
using namespace std;
void getMaxSubArraySum(vector<int> &arr, int n) {
    int currSum = 0;
    int maxSum = INT_MIN;
    for(int i=0;i<n;i++) {
        currSum += arr[i];
        if(currSum>maxSum) maxSum = currSum;
        if(currSum<0) currSum = 0;
    }
    cout<<"Maximum Sum is: "<<maxSum<<endl;
}
int main() {
    vector<int> arr = {-2,-3,4,-1,-2,1,5,-3};
    getMaxSubArraySum(arr,arr.size());
    return 0;
}