# _rt_origin.mcfunction
#
# BUILD-TIME PROVENANCE WATERMARK — not a gameplay function.
# This file is NOT registered in any load/tick tag and does nothing if run.
# It exists purely so the Gradle build can prove, at zip time, that this
# pack folder came from the runtoolkit/suite monorepo and was not hand-
# assembled or swapped out before packaging.
#
# This file is deleted automatically by the `cleanOriginWatermarks` Gradle
# task, which only runs AFTER `zipPacks` has finished (see root build.gradle,
# finalizedBy wiring). Do not delete it manually — `zipPacks` will fail the
# build if a pack under packs/ is missing its _rt_origin.mcfunction, since
# that means the provenance check can no longer run before packaging.
#
# repo:    runtoolkit/suite
# path:    packs/macroEngine-Datapack-v26.3
# commit:  930e33357f8750af6c74632ba503564fe0ceaec6
# date:    2026-09-14T13:46:59+03:00
# pack:    macroEngine-Datapack-v26.3
