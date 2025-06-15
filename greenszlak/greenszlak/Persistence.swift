import CoreData
import MapKit


class PersistenceController {
    static let shared = PersistenceController()

    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        result.loadSampleData(context: viewContext)
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "greenszlak")
        let description = container.persistentStoreDescriptions.first
        description?.shouldMigrateStoreAutomatically = true
        description?.shouldInferMappingModelAutomatically = true
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }

            let context = self.container.viewContext
            let request: NSFetchRequest<Plant> = Plant.fetchRequest()
            request.fetchLimit = 1
            if let count = try? context.count(for: request), count == 0 {
                self.loadSampleData(context: context)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    private func loadSampleData(context: NSManagedObjectContext) {
        // Create sample districts with plants
        let districtsData: [DistrictModel] = [
            DistrictModel(
                id: UUID(),
                name: "Śródmieście",
                timestamp: Date(),
                center: CLLocationCoordinate2D(latitude: 51.2485, longitude: 22.5655),
                plants: [
                    PlantModel(
                        id: UUID(),
                        name: "Klon",
                        info: "Klon to drzewo liściaste o charakterystycznych dłoniastych, klapowanych liściach. Jego drewno jest twarde i cenione w stolarstwie.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2485, longitude: 22.5650),
                        imageID: "klon",
                        tags: [.tree]
                    ),
                    PlantModel(
                        id: UUID(),
                        name: "Jesion",
                        info: "Drzewo liściaste o silnym, prostym pniu i jasnozielonych liściach. Często używany do produkcji mebli i narzędzi ze względu na wytrzymałe drewno.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2490, longitude: 22.5660),
                        imageID: "jesion",
                        tags: [.tree]
                    )
                ]
            ),
            DistrictModel(
                id: UUID(),
                name: "Sławinek",
                timestamp: Date(),
                center: CLLocationCoordinate2D(latitude: 51.2645, longitude: 22.5350),
                plants: [
                    PlantModel(
                        id: UUID(),
                        name: "Lipa",
                        info: "Drzewo o sercowatych liściach i pachnących kwiatach, ważne dla pszczół. Drewno lipowe jest miękkie i łatwe do rzeźbienia.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2647, longitude: 22.5355),
                        imageID: "lipa",
                        tags: [.tree]
                    ),
                    PlantModel(
                        id: UUID(),
                        name: "Wiśnia",
                        info: "Drzewo owocowe o pięknych, różowych kwiatach i smacznych owocach. Drewno wiśniowe jest cenione za ciepły, czerwony kolor i trwałość.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2635, longitude: 22.5340),
                        imageID: "wisnia",
                        tags: [.tree]
                    )
                ]
            ),
            DistrictModel(
                id: UUID(),
                name: "Czechów",
                timestamp: Date(),
                center: CLLocationCoordinate2D(latitude: 51.2700, longitude: 22.5600),
                plants: [
                    PlantModel(
                        id: UUID(),
                        name: "Sosna",
                        info: "Drzewo iglaste o długich igłach i charakterystycznym zapachu żywicy. Drewno sosnowe jest lekkie, łatwe w obróbce i szeroko stosowane w budownictwie.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2710, longitude: 22.5610),
                        imageID: "sosna",
                        tags: [.tree]
                    ),
                    PlantModel(
                        id: UUID(),
                        name: "Dąb",
                        info: "Drzewo o mocnym, twardym drewnie i charakterystycznych klapowanych liściach. Drewno dębowe jest trwałe i odporne na wilgoć, często używane do produkcji beczek i mebli.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2690, longitude: 22.5590),
                        imageID: "dab",
                        tags: [.tree]
                    )
                ]
            ),
            DistrictModel(
                id: UUID(),
                name: "Wieniawa",
                timestamp: Date(),
                center: CLLocationCoordinate2D(latitude: 51.2470, longitude: 22.5550),
                plants: [
                    PlantModel(
                        id: UUID(),
                        name: "Grab",
                        info: "Drzewo liściaste o drobnych liściach i twardym drewnie. Grab jest często wykorzystywany jako drewno opałowe oraz do wyrobu narzędzi.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2475, longitude: 22.5555),
                        imageID: "grab",
                        tags: [.tree]
                    ),
                    PlantModel(
                        id: UUID(),
                        name: "Buk",
                        info: "Drzewo o gładkiej korze i dużych liściach. Drewno bukowe jest twarde, elastyczne i popularne w meblarstwie oraz produkcji podłóg.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2465, longitude: 22.5540),
                        imageID: "buk",
                        tags: [.tree]
                    )
                ]
            ),
            DistrictModel(
                id: UUID(),
                name: "Rury",
                timestamp: Date(),
                center: CLLocationCoordinate2D(latitude: 51.2350, longitude: 22.5600),
                plants: [
                    PlantModel(
                        id: UUID(),
                        name: "Jodła",
                        info: "Drzewo iglaste o stożkowatym kształcie i miękkich igłach. Drewno jodłowe jest lekkie i stosowane w budownictwie oraz do produkcji papieru.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2340, longitude: 22.5610),
                        imageID: "jodla",
                        tags: [.tree]
                    ),
                    PlantModel(
                        id: UUID(),
                        name: "Olcha",
                        info: "Drzewo rosnące często nad wodą, o lekko czerwonym drewnie. Drewno olchowe jest miękkie i używane do wyrobu mebli oraz instrumentów muzycznych.",
                        timestamp: Date(),
                        coordinate: CLLocationCoordinate2D(latitude: 51.2355, longitude: 22.5595),
                        imageID: "olcha",
                        tags: [.tree]
                    )
                ]
            )
        ]

        // Create districts and associated plants
        for districtModel in districtsData {
            // Create district
            let district = District.from(districtModel, context: context)

            // Create plants for this district
            for plantModel in districtModel.plants {
                let plant = Plant.from(plantModel, context: context)
                plant.district = district
            }
        }

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Failed to preload sample data: $nsError), $nsError.userInfo)")
        }
    }
}
