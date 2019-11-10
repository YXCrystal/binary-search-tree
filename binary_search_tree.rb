class Node
    attr_accessor :value, :parent_node, :left_child, :right_child
    def initialize(value)
        @value = value
        @parent_node = nil
        @left_child = nil
        @right_child = nil
    end
end

class Tree
    attr_accessor :root
    def initialize(array)
        @root = nil
        build_tree(array)
    end

    def build_tree(array)
        @root = Node.new(array[0])
        array[1..-1].each do |num|
            new_node = Node.new(num)
            add_node(@root, new_node)
        end
    end

    def add_node(parent, child)
        child.parent_node = parent
        if parent.value >= child.value
            if parent.left_child.nil?
                parent.left_child = child
            else
                add_node(parent.left_child, child)
            end
        elsif parent.value < child.value
            if parent.right_child.nil?
                parent.right_child = child
            else
                add_node(parent.right_child, child)
            end
        end
    end

    def insert(value)
        new_node = Node.new(value)
        add_node(@root, new_node)
    end

    def delete(node = @root, value)
        node = find(@root, value)
        
        if !node.nil?
            if node.parent_node.right_child.value == value
                node.parent_node.right_child = nil
            else
                node.parent_node.left_child = nil
            end
        else
            puts "Does not exist"
        end
    end

    def find(node = @root, value)
        if node.nil?
            return
        elsif node.value == value
            node
        elsif node.value > value
            find(node.left_child, value)
        elsif node.value < value
            find(node.right_child, value)
        end
    end

    def breadth_first_search(target)
        queue = []
        current_node = @root

        until queue.nil? 
            return 'Target value does not exist' if current_node.nil?
            return current_node if current_node.value == target

            queue << current_node.left_child unless current_node.left_child.nil?
            queue << current_node.right_child unless current_node.right_child.nil?

            current_node = queue.shift
        end
    end

    def depth_first_search(target)
        stack = []
        current_node = @root

        until stack.nil?
            return 'Target value does not exist' if current_node.nil?
            return current_node if current_node.value == target

            stack << current_node.right_child unless current_node.right_child.nil?
            stack << current_node.left_child unless current_node.left_child.nil?

            current_node = stack.pop
        end
    end
end

# test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9])
test = Tree.new([2, 3, 1, 5])
test.insert(8)
puts test.breadth_first_search(3)
puts test.depth_first_search(3)
# puts test.breadth_first_searh(3).inspect
