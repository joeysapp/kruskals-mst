public class WeightComp implements Comparator<Edge> {
  @Override
    public int compare(Edge a1, Edge a2) {
    return a2.getWeight().compareTo(a1.getWeight());
  }
}