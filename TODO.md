# vov
- _.datamodel_ : Ensure **tagsRaw** is configured with _NSKeyedUnarchiveValueTransformerName_ in the Core Data model inspector. This ensures safe encoding/decoding of [String] arrays. Why? Without this, Core Data may fail to serialize/deserialize the attribute, leading to crashes or data loss.
- fix shitty code written remotely with no way to test it (hate mac, hate ios 😮‍💨)

# nat
- review edits in _ContentView_, _Persistence_
- fix shitty code written by `vov`

# yan
- create views:
    + add plant ui via _View/AddPlantView_
    + integrate _View/TagPicker_ into plant creation view
