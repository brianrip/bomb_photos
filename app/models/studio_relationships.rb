class StudioRelationships
  def self.build(studio, current_user)
    studio.update(status: 2)
    current_user.update_attribute(:studio_id, studio.id)
    current_user.roles << Role.find_or_create_by(name: "studio admin")
  end
end
