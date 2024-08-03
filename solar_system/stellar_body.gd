
const PlanetAtmosphere = preload("res://addons/zylann.atmosphere/planet_atmosphere.gd")
const Settings = preload("res://settings.gd")
const Waypoint = preload("res://waypoints/waypoint.gd")

const TYPE_MAIN_SEQUENCE_STAR = 0  # e.g. Sun
const TYPE_RED_GIANT_STAR = 1  # e.g. Betelgeuse
const TYPE_WHITE_DWARF_STAR = 2  # e.g. Sirius B
const TYPE_NEUTRON_STAR = 3  # e.g. PSR J0348+0432
const TYPE_BLACK_HOLE = 4  # e.g. Cygnus X-1

const TYPE_TERRESTRIAL_PLANET = 5  # e.g. Mercury, Mars, Earth, Kepler-452b
const TYPE_GAS_GIANT = 6  # e.g. Jupiter, Saturn, Kepler-11b
const TYPE_ICE_GIANT = 7  # e.g. Uranus, Neptune

const TYPE_DWARF_PLANET = 8  # e.g. Pluto, Eris
const TYPE_ASTEROID = 9  # e.g. Ceres, Vesta
const TYPE_COMET = 10  # e.g. Halley's Comet
const TYPE_KUIPER_BELT_OBJECT = 11  # e.g. Quaoar, Makemake
const TYPE_OORT_CLOUD_OBJECT = 12  # e.g. Sedna

const TYPE_MOON = 13  # e.g. Moon, Io, Europa
const TYPE_ASTEROID_BELT = 14  # e.g. asteroid belt between Mars and Jupiter
const TYPE_DEEP_SPACE = 15  # e.g. not close to any stellar bodies

const ATMOSPHERE_DISABLED = 0
const ATMOSPHERE_MONOCHROME = 1
const ATMOSPHERE_WITH_SCATTERING = 2

# Static values
var name := ""
var type := TYPE_DEEP_SPACE
var parent_id := -1
var radius := 0.0
var distance_to_parent := 0.0
var orbit_revolution_time := 0.0
var self_revolution_time := 0.0
var orbit_tilt := 0.0
var self_tilt := 0.0

var atmosphere_mode := ATMOSPHERE_DISABLED
var atmosphere_color := Color(0.5, 0.7, 1.0)
var atmosphere_ambient_color := Color(0.0, 0.0, 0.0)

var sea := false
var day_ambient_sound : AudioStream
var night_ambient_sound : AudioStream
var clouds_coverage_cubemap : Cubemap
var clouds_coverage_bias := 0.0

# State values
var orbit_revolution_progress := 0.0
var self_revolution_progress := 0.0
var day_count := 0
var year_count := 0
var static_bodies_are_in_tree := false

var waypoints : Array[Waypoint] = []

# Godot stuff
var node : Node3D
var volume : VoxelLodTerrain
var instancer : VoxelInstancer
var atmosphere : PlanetAtmosphere
var static_bodies : Array[StaticBody3D] = []


func _notification(what: int):
	if what == NOTIFICATION_PREDELETE:
		if not static_bodies_are_in_tree:
			for sb in static_bodies:
				sb.free()

