#include <bits/stdc++.h>
using namespace std;
 void solve(vector<int>&nums, int&sum, vector<int>&ds,int ind, int s) {
     // base case
     if(ind >= nums.size()) {
         if(sum == s) {
             for(int num : ds) {
                 cout<<num<<" ";
             }
             cout<<endl;
         }
         return ;
     }
     // pick the element
     ds.push_back(nums[ind]);
     s += nums[ind];
     solve(nums, sum, ds, ind+1, s);
     ds.pop_back();
     s -= nums[ind];
     // not to pick
     solve(nums, sum, ds, ind+1, s);
 }
 void getAllSubArrayWithSumK(vector<int>&nums, int sum) {
     vector<int> ds;
     int ind = 0, s = 0;
     solve(nums, sum, ds,ind, s);
 }
  
int main() {
	vector<int> nums = {1,2,1};
	int k = 2;
	getAllSubArrayWithSumK(nums, k);
	return 0;
}
