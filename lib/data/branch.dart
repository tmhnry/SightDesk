import 'helpers.dart';
import 'names.dart' as names;
import 'ids.dart' as ids;

//  use Map<dynamic, dynamic> topics in Future<Course> create({required Map<dynamic,dynamic> topics}) if one of the topics below evaluate to {}
final Map<String, dynamic> rootBranches = {
  ids.engineering: {
    name: names.engineering,
    fields: {
      ids.mechanical_engineering: {
        name: names.mechanical_engineering,
        courses: {
          ids.elements_of_mechanical_design: {
            name: names.elements_of_mechanical_design,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
          ids.mechanics_and_materials: {
            name: names.mechanics_and_materials,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
          ids.engineering_dynamics: {
            name: names.engineering_dynamics,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
          ids.power_plant_engineering: {
            name: names.power_plant_engineering,
            topics: {
              ids.first_law_of_thermodynamics: {
                name: names.first_law_of_thermodynamics,
              }
            },
          },
          ids.industrial_and_power_plant_engineering: {
            name: names.industrial_plant_engineering,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
        }
      }
    }
  },
  ids.humanities_arts_and_social_sciences: {
    name: names.humanities_arts_and_social_sciences,
    fields: {
      ids.economics: {
        name: names.economics,
        courses: {
          ids.engineering_economics: {
            name: names.engineering_economics,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
        }
      }
    }
  },
  ids.science: {
    name: names.science,
    fields: {
      ids.chemistry: {
        name: names.chemistry,
        courses: {
          ids.organic_chemistry_i: {
            name: names.organic_chemistry_i,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
          ids.organic_chemistry_ii: {
            name: names.organic_chemistry_ii,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
        }
      },
      ids.physics: {
        name: names.physics,
        courses: {
          ids.physics_i: {
            name: names.physics_i,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
          ids.physics_ii: {
            name: names.physics_ii,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
        }
      },
      ids.mathematics: {
        name: names.mathematics,
        courses: {
          ids.college_algebra: {
            name: names.college_algebra,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
          ids.probability_and_statistics: {
            name: names.probability_and_statistics,
            topics: {
              ids.probability_of_independent_events: {
                name: names.probability_of_independent_events,
              }
            },
          },
          ids.single_variable_calculus_i: {
            name: names.single_variable_calculus_i,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
          ids.single_variable_calculus_ii: {
            name: names.single_variable_calculus_ii,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
          ids.differential_equations: {
            name: names.differential_equations,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
          ids.mathematical_methods_for_engineers: {
            name: names.mathematical_methods_for_engineers,
            topics: {
              ids.bolts_and_screws: {
                name: names.bolts_and_screws,
              },
            },
          },
        }
      }
    }
  },
};
