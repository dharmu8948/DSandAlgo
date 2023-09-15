// Online C++ compiler to run C++ program online
// WAP to print All SubArray
/*
I/p: nums:[1,2,3,4,5]
O/P: 
1 
1 2 
1 2 3 
1 2 3 4 
1 2 3 4 5 
2 
2 3 
2 3 4 
2 3 4 5 
3 
3 4 
3 4 5 
4 
4 5 
5 




*/
#include <bits/stdc++.h>
using namespace std;

void printAllSubArray_utils(vector<int>&nums, int start, int end){
    // base case
    if(end>=nums.size()) {
        return ;
    }
    // ek case solve karna hai
    for(int i=start;i<=end;i++) {
        cout<<nums[i]<<" ";
    }
    cout<<endl;
    // baki recursion sambhal lega
    printAllSubArray_utils(nums,start, end+1);
}
void printAllSubArray(vector<int>&nums) {
    for(int start = 0;start<nums.size();start++) {
        int end = start;
        printAllSubArray_utils(nums, start, end);
    }
}
int main() {
    vector<int> arr = {1,2,3,4,5,6,7,8,9};
    printAllSubArray(arr);

    return 0;
}