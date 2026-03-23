#include <bits/stdc++.h>
using namespace std;

 void solve(vector<int>& candidates, int target,vector<vector<int>>&ans, vector<int> temp, int idx) {
        // base case
        if(target  < 0) return ;
        if(idx >= candidates.size()) {
            if(target == 0) ans.push_back(temp);
            return ;
        }
        // pick the element
        temp.push_back(candidates[idx]);
        solve(candidates, target - candidates[idx], ans, temp, idx);
        temp.pop_back();

        // not to pick
        solve(candidates, target, ans, temp, idx+1);
    }
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        vector<vector<int>> ans;
        vector<int> temp;
        int index = 0;
        solve(candidates, target, ans, temp, index);
        return ans;
    }
    void printAllCombinations(vector<vector<int>> ans) {
        for(auto arr : ans) {
            cout<<"[ ";
            for(auto num : arr) {
                cout<<num<<" ";
            }
            cout<<"]"<<endl;
        }
    }
int main() {
    vector<int> candidates = {2,3,6,7};
    int target = 7;
	vector<vector<int>> ans;
	ans = combinationSum(candidates, target); //out : [[2,2,3],[7]]
	
	//print combinations 
	printAllCombinations(ans);

}
