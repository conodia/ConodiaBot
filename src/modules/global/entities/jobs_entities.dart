class JobsEntity {
  final int id;
  final JobEntity miner;
  final JobEntity woodcutter;
  final JobEntity farmer;
  final JobEntity hunter;
  final JobEntity constructor;

  JobsEntity(this.id, this.miner, this.woodcutter, this.farmer, this.hunter, this.constructor);

  factory JobsEntity.from(dynamic map) {
    return JobsEntity(
      map['id'],
      JobEntity.from(map['jobs']['miner']),
      JobEntity.from(map['jobs']['woodcutter']),
      JobEntity.from(map['jobs']['farmer']),
      JobEntity.from(map['jobs']['hunter']),
      JobEntity.from(map['jobs']['builder']),
    );
  }
}

class JobEntity {
  int level;
  double xp;

  JobEntity(this.level, this.xp);

  factory JobEntity.from(dynamic map) {
    return JobEntity(map['level'], map['xp'] + 0.0);
  }
}