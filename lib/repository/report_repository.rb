class ReportRepository
  def report
    total_uninfected = User.all.count
    total_infected = User.only_deleted.count
    total_all = total_uninfected + total_infected
    lost_points = Inventory.only_deleted.where('quantity > 0').sum('point * quantity')
    points_water = load_lost_points('água', total_uninfected)
    points_food = load_lost_points('comida', total_uninfected)
    points_medicine = load_lost_points('medicamento', total_uninfected)
    points_ammnunition = load_lost_points('munição', total_uninfected)

    return { 
        percentage_of_infected_users: "#{(100 * total_infected) / total_all} %",
        percentage_of_uninfected_users: "#{(100 * total_uninfected) / total_all} %",
        average_quantity_of_each_item_type_per_user: 
        {
          water: "#{points_water}",
          food: "#{points_food}",
          medicine: "#{points_medicine}",
          ammunition: "#{points_ammnunition}"
        },
        number_of_points_lost_by_infected_users: lost_points,
        }, status: '200'
  end

  def load_lost_points(item, total_uninfected)
    Inventory.where(item: item).where('quantity > 0').sum('quantity') / total_uninfected
  end

end