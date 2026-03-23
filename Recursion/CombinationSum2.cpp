#include <bits/stdc++.h>
using namespace std;

 void solve(int idx, vector<int>& candidates, int target, vector<vector<int>>&ans, vector<int> temp) {
        // If Target became 0 it means combination found, store it into ans array
        if(target == 0) {
            ans.push_back(temp);
            return;
        }
        // check all elements from current index till array size
        for(int i = idx ; i < candidates.size() ; i++) {
            // This is the Case Where We are avoiding duplicate combinations
            if(i > idx && candidates[i] == candidates[i-1]) continue;
            // This is the Case Where we can break if target less than current ele, and no need to check further, because it is in sorted order
            if(candidates[i] > target) break;
            // here we can push the element
            temp.push_back(candidates[i]);
            // recursion call
            solve(i+1, candidates, target - candidates[i], ans, temp);
            //backtrack
            temp.pop_back();
        }
    }
    vector<vector<int>> combinationSum2(vector<int>& candidates, int target) {
        sort(candidates.begin(), candidates.end());
        vector<vector<int>> ans;
        vector<int> temp;
        solve(0,candidates, target, ans, temp);
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
    vector<int> candidates = {10,1,2,7,6,1,5};
    int target = 8;
	vector<vector<int>> ans;
	ans = combinationSum2(candidates, target); //out : [[2,2,3],[7]]
	
	//print combinations 
	printAllCombinations(ans);

}
