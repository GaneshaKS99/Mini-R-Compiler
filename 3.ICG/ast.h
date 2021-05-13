struct BTree 
{
    struct BTree* left;
    struct BTree* cur;
    int what;
    union
    {
        int op;
    }value;
    struct BTree* right;
};
