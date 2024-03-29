// C++ program to print total
// count of nodes in BST
#include <bits/stdc++.h>
using namespace std;

// Given Node node
struct node {
	int key;
	struct node *left, *right;
};

// Function to create a new BST node
struct node* newNode(int item)
{
	struct node* temp
		= (struct node*)malloc(
			sizeof(struct node));
	temp->key = item;
	temp->left = temp->right = NULL;
	return temp;
}

// Function to insert a new node with
// given key in BST
struct node* insert(struct node* node, int key)
{
	// If the tree is empty, return a new node
	if (node == NULL)
		return newNode(key);

	// Otherwise, recur down the tree
	if (key < node->key) {
		node->left = insert(node->left, key);
	}
	else if (key > node->key) {
		node->right = insert(node->right, key);
	}

	// Return the node pointer
	return node;
}

// Function to get the total count of
// nodes in a binary tree
bool search(struct node* root, int data)
{
	if (root == NULL) return false;
	if(root->key == data)
		     return true;

	else if(root->key > data)
		return search(root->left, data);
	else
	   return search(root->right, data);
}

// Driver Code
int main()
{
	/* Let us create following BST 
			50 
		  /	 \ 
		 30	  70 
		/ \   / \ 
       20 40 60 80 
*/
	struct node* root = NULL;

	// Creating the BST
	root = insert(root, 50);
	insert(root, 30);
	insert(root, 20);
	insert(root, 40);
	insert(root, 70);
	insert(root, 60);
	insert(root, 80);

	// Function Call
	string result = search(root, 30)== 1 ? "Element found": "Element not found";
	cout <<result<<endl<<endl;

	return 0;
}

// This code is contributed by shivanisinghss2110
