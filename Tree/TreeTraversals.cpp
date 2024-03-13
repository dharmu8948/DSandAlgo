// C++ program to insert a node
// in a BST
#include <bits/stdc++.h>
using namespace std;

// Given Node
struct node
{
	int key;
	struct node *left, *right;
};

// Function to create a new BST node
struct node* newNode(int item)
{
	struct node* temp = (struct node*)malloc(
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
	if (key < node->key)
	{
		node->left = insert(node->left, key);
	}
	else if (key > node->key)
	{
		node->right = insert(node->right, key);
	}

	// Return the node pointer
	return node;
}

// Function to do inorder traversal of BST
void inorder(struct node* root)
{
	if (root != NULL) 
	{
		inorder(root->left);
		cout << root->key << " ";
		inorder(root->right);
	}
}
// Function to do preorder traversal of BST
void preorder(struct node* root) {
    if(root != NULL) {
        cout<<root->key<<" ";
        preorder(root->left);
        preorder(root->right);
    }
}
// Function to do postorder traversal of BST
void postorder(struct node* root) {
    if(root != NULL) {
        postorder(root->left);
        postorder(root->right);
        cout<<root->key<<" ";
    }
}
void levelOrder(struct node* root) {
    queue<node*> q;
    q.push(root);
    while(!q.empty()) {
        node* temp = q.front();
		q.pop();
		if(temp == NULL) {
			if(!q.empty()) {
				q.push(NULL);
			}	
		}else {
		    cout << temp->key << " ";
			//D
			if(temp -> left) {
				q.push(temp ->left);
			}
			if(temp ->right) {
				q.push(temp->right);
			}
		}
    }
}
// Driver Code
int main()
{
	
	/* Let us create following BST 
			50 
		  /	 \ 
		30	 70 
	  / \    / \ 
	20 40   60 80 
*/
	struct node* root = NULL;

	// Inserting value 50
	root = insert(root, 50);

	// Inserting value 30
	insert(root, 30);

	// Inserting value 20
	insert(root, 20);

	// Inserting value 40
	insert(root, 40);

	// Inserting value 70
	insert(root, 70);

	// Inserting value 60
	insert(root, 60);

	// Inserting value 80
	insert(root, 80);

	// Print the BST
	cout<<"Printing Elements using inorder Triversal:: ";
	inorder(root);
	cout<<endl<<endl;
	cout<<"Printing Elements using preorder Triversal:: ";
	preorder(root);
	cout<<endl<<endl;
	cout<<"Printing Elements using postorder Triversal:: ";
	postorder(root);
	cout<<endl<<endl;
	cout<<"Printing Elements using levelOrder Triversal:: ";
	levelOrder(root);
	cout<<endl<<endl;

	return 0;
}

// This code is contributed by shubhamsingh10
