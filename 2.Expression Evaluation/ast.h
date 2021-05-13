struct BTree 
{
    struct BTree* left;
    int datatype;
    struct BTree* cur;
    int what;
    union
    {
        int op;
        float val;
        char *str;
    }value;
    struct BTree* right;
};