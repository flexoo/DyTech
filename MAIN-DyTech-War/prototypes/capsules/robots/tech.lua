data:extend(
{
  {
    type = "technology",
    name = "combat-robotics-4",
    icon = "__base__/graphics/technology/combat-robotics.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "marauder-capsule"
      },
      {
        type = "unlock-recipe",
        recipe = "marauder-turret-capsule"
      },
    },
    prerequisites = {"combat-robotics-3"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"alien-science-pack", 1}
      },
      time = 30
    },
    order = "e-p-b-b",
	upgrade = true
  },
  {
    type = "technology",
    name = "combat-robotics-5",
    icon = "__base__/graphics/technology/combat-robotics.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "sharpshooter-capsule"
      },
      {
        type = "unlock-recipe",
        recipe = "sharpshooter-turret-capsule"
      },
    },
    prerequisites = {"combat-robotics-4"},
    unit =
    {
      count = 800,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"alien-science-pack", 1}
      },
      time = 30
    },
    order = "e-p-b-b",
	upgrade = true
  },
  {
    type = "technology",
    name = "combat-robotics-6",
    icon = "__base__/graphics/technology/combat-robotics.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "frenzy-capsule"
      },
      {
        type = "unlock-recipe",
        recipe = "frenzy-turret-capsule"
      },
      {
        type = "unlock-recipe",
        recipe = "mixed-capsule"
      },
      {
        type = "unlock-recipe",
        recipe = "mixed-turret-capsule"
      },
    },
    prerequisites = {"combat-robotics-5"},
    unit =
    {
      count = 2500,
      ingredients =
      {
        {"science-pack-1", 3},
        {"science-pack-2", 2},
        {"science-pack-3", 2},
        {"alien-science-pack", 1}
      },
      time = 45
    },
    order = "e-p-b-b",
	upgrade = true
  },
}
)