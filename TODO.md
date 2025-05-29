# vov
- _.datamodel_ : Ensure **tagsRaw** is configured with _NSKeyedUnarchiveValueTransformerName_ in the Core Data model inspector. This ensures safe encoding/decoding of [String] arrays. Why? Without this, Core Data may fail to serialize/deserialize the attribute, leading to crashes or data loss.
- fix shitty code written remotely with no way to test it (hate mac, hate ios 😮‍💨)

# nat
- review edits in _ContentView_, _Persistence_

# yan
- create views:
    + add plant (pops on fab button click)
    + integrate _View/TagPicker_ into pland creation view
