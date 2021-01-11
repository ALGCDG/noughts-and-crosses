struct coordinate
{
    char x;
    char y;
}; // coordinate;

struct state
{
    struct coordinate * max_visited;
    int number_max_visited;
    struct coordinate * min_visited;
    int number_min_visited;
}; // state;

struct node
{
    struct node * next;
    struct state s;
}; // list_node;

char valid_position(char x, char y)
{
    return x < 4 && x > 0 && y < 4 && y > 0;
}

char same_coordinate(struct coordinate * a, struct coordinate * b)
{
    return a->x==b->x && a->y==b->y;
}

char goal(struct state s)
{
    return 0;
}

char fail(struct state s)
{
    return 0;
}

char stail(struct state s)
{
    return 0;
}

struct state * change(char turn, struct state * s)
{
    int x, y, i;
    struct coordinate new;
    char already_claimed;
    struct state child;
    struct node * children;
    struct node * ptr;
    int no_children = 0;
    for (x=1; x<4; x++)
        for (y=1; y<4; y++)
        {
            new = {x,y};
            // check that this move has not already been done
            already_claimed = 0;
            for (i=0; i<s->number_max_visited; i++)
                already_claimed |= same_coordinate(&(s->max_visited[i]), &new);
            for (i=0; i<s->number_min_visited; i++)
                already_claimed |= same_coordinate(&(s->min_visited[i]), &new);
            if (already_claimed)
                continue;
            // create a child state
            child = new struct state;
            child.max_visited = new struct coordinate[s->number_max_visited+(turn?1:0)];
            child.min_visited = new struct coordinate[s->number_min_visited+(turn?0:1)];
            // copy the already visited coordiantes
            for (i=0; i<s->number_max_visited; i++)
                child.max_visited[i] = s->max_visited[i];
            for (i=0; i<s->number_min_visited; i++)
                child.min_visited[i] = s->min_visited[i];
            // add new visited state to child
            if (turn)
                child.max_visited[s->number_max_visited] = new;
            else
                child.min_visited[s->number_min_visited] = new;

        }
}

int max(int size, int * array)
{
    int i, max;
    max = 0
    for (i=0; i<size; i++)
        if (array[i]>max)
            max=array[i];
    return max;
}

int min(int size, int * array)
{
    int i, min;
    min = array[0]; // weassume that the size is 1 or more;
    for (i=0; i<size; i++)
        if (array[i]<min)
            min=array[i];
    return min;
}

int minimax(char turn, struct state * s)
{
    if (goal(s))
        return 1;
    else if (fail(s))
        return -1;
    else if (stail(s))
        return 0;
    else
    {
        struct node * children = change(turn, s)
        struct state * child =
        int no_children;
        int i;
        int[] values = new int[no_children]
        for (i=0; i<no_children; i++)
        {
            
            values[i] = minimax(!turn, children->s);
            children = children->next; // iterate through linked list
        }
        if (turn)
            return max(no_children, values);
        else
            return min(no_children, values);
    }
}

int main()
{
    struct state start_state = {NULL, 0, NULL, 0};
    return 0;
}
