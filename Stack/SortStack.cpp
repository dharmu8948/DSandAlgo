// Sort A Stack
#include <bits/stdc++.h>
using namespace std;
void sortedInsert(stack<int> &s,int num) {
	if(s.empty() || (!s.empty() && s.top()<num)) {
		s.push(num);
		return ;
	}
	int n = s.top();
	s.pop();
	sortedInsert(s,num);
	s.push(n);
}

void sortStack(stack<int> &stack)
{
	if(stack.empty()) {
		return ;
	}
	int num = stack.top();
	stack.pop();
	sortStack(stack);
	sortedInsert(stack,num);
}
int main() {
   stack<int> st;
   st.push(7);
   st.push(1);
   st.push(4);
   st.push(5);
   st.push(0);
   sortStack(st);
   //printing
     while(!st.empty()) {
       cout<<st.top()<<" ";
       st.pop();
   }
}