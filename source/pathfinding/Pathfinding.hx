package pathfinding;

import pathfinding.core.IMap;
import pathfinding.core.Heuristic;
import pathfinding.core.Node;
import pathfinding.core.Path;

import pathfinding.algorithms.AStar;

/**
 * We need to find the path... follow the white rabbit.
 *
 * @author Yura Zatsepin
 */
class Pathfinding
{
	public var map:IMap;
	private var aStar:AStar;

	public function new(map:IMap)
	{
		this.map = map;
		aStar = new AStar();
	}

	public function findPath(start:Node, goal:Node):Path 
	{
		if(start != null && goal != null && start.walkable && goal.walkable)
		{
			var path = aStar.search(start, goal, map);
			for (n in map.nodes)
				n.reset();
			return path;
		}
		else 
		{
			return Path.INVALID;
		}
	}

	/**
	 * Backtrace according to the parent records and return the path.
	 * (including both start and end nodes)
	 * @param node End node
	 * @return the path
	 */
	public static function backtrace(node:Node):Path {
		var path:Path = new Path();
		path.nodes.push(node);
		while (node.parent != null) {
			node = node.parent;
			path.nodes.push(node);
		}
		path.nodes.reverse();
        for (node in path.nodes)
          node.parent = null;
		return path;
	}
}
