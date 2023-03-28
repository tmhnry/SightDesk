import './helpers.dart';
import './ids.dart' as ids;
import './names.dart' as names;

final psets = {
  ids.bsme: {
    ids.machine_design_materials_and_shop_practice: {
      name: names.machine_design_materials_and_shop_practice,
      value: 0.3,
    },
    ids.industrial_and_power_plant_engineering: {
      name: names.industrial_and_power_plant_engineering,
      value: 0.35
    },
    ids.mathematics_engineering_economics_and_basic_sciences: {
      name: names.mathematics_engineering_economics_and_basic_sciences,
      value: 0.35,
    }
  }
};

final courseTopics = {
  ids.elements_of_mechanical_design: {
    ids.bolts_and_screws: {name: names.bolts_and_screws}
  },
  ids.power_plant_engineering: {
    ids.first_law_of_thermodynamics: {name: names.first_law_of_thermodynamics}
  },
  ids.probability_and_statistics: {
    ids.probability_of_independent_events: {
      name: names.probability_of_independent_events
    },
  }
};

final topicProblems = {
  ids.bolts_and_screws: ['A02AA', 'A02AB', 'A02AC', 'A02AD', 'A02AE', 'A02AF'],
  ids.first_law_of_thermodynamics: ['A02BA', 'A02BB'],
  ids.probability_of_independent_events: ['A02CA', 'A02CB'],
};

final psetCourses = {
  ids.machine_design_materials_and_shop_practice: {
    ids.elements_of_mechanical_design: {
      name: names.elements_of_mechanical_design
    },
    ids.engineering_dynamics: {name: names.engineering_dynamics},
  },
  ids.industrial_and_power_plant_engineering: {
    ids.power_plant_engineering: {name: names.power_plant_engineering}
  },
  ids.mathematics_engineering_economics_and_basic_sciences: {
    ids.probability_and_statistics: {name: names.probability_and_statistics}
  }
};
