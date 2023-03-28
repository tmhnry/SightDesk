import './helpers.dart';
import './ids.dart' as ids;
import './names.dart' as names;

final institutions = {
  ids.sightdesk_ph: {
    date: '2021-10-08T14:34:27.395',
    name: names.sightdesk_ph,
  },
};

final branches = {
  ids.sightdesk_ph: {
    ids.engineering: {
      name: names.engineering,
    },
    ids.humanities_arts_and_social_sciences: {
      name: names.humanities_arts_and_social_sciences,
    },
    ids.science: {
      name: names.science,
    }
  }
};

final topics = {
  ids.elements_of_mechanical_design: {
    ids.bolts_and_screws: {
      name: names.bolts_and_screws,
    },
  },
  ids.mechanics_and_materials: {
    ids.bolts_and_screws: {
      name: names.bolts_and_screws,
    },
  },
  ids.engineering_dynamics: {
    ids.bolts_and_screws: {
      name: names.bolts_and_screws,
    },
  },
  ids.power_plant_engineering: {
    ids.first_law_of_thermodynamics: {
      name: names.first_law_of_thermodynamics,
    },
  },
  ids.industrial_plant_engineering: <String, Map<String, String>>{},
  ids.engineering_economics: <String, Map<String, String>>{},
  ids.probability_and_statistics: {
    ids.probability_of_independent_events: {
      name: names.probability_of_independent_events
    }
  }
};

final courses = {
  ids.mechanical_engineering: {
    ids.elements_of_mechanical_design: {
      name: names.elements_of_mechanical_design,
    },
    ids.mechanics_and_materials: {name: names.mechanics_and_materials},
    ids.engineering_dynamics: {name: names.engineering_dynamics},
    ids.power_plant_engineering: {name: names.power_plant_engineering},
    ids.industrial_plant_engineering: {
      name: names.industrial_plant_engineering
    },
  },
  ids.economics: {
    ids.engineering_economics: {name: names.engineering_economics},
  },
  ids.chemistry: {
    ids.organic_chemistry_i: {name: names.organic_chemistry_i},
    ids.organic_chemistry_ii: {name: names.organic_chemistry_ii}
  },
  ids.physics: {
    ids.physics_i: {name: names.physics_i},
    ids.physics_ii: {name: names.physics_ii},
  },
  ids.mathematics: {
    ids.college_algebra: {name: names.college_algebra},
    ids.probability_and_statistics: {name: names.probability_and_statistics},
    ids.single_variable_calculus_i: {name: names.single_variable_calculus_i},
    ids.single_variable_calculus_ii: {name: names.single_variable_calculus_ii},
    ids.differential_equations: {name: names.differential_equations},
    ids.mathematical_methods_for_engineers: {
      name: names.mathematical_methods_for_engineers
    },
  }
};

final fields = {
  ids.engineering: {
    ids.mechanical_engineering: {
      name: names.mechanical_engineering,
    }
  },
  ids.humanities_arts_and_social_sciences: {
    ids.economics: {
      name: names.economics,
    }
  },
  ids.science: {
    ids.chemistry: {
      name: names.chemistry,
    },
    ids.physics: {
      name: names.physics,
    },
    ids.mathematics: {
      name: names.mathematics,
    }
  }
};
